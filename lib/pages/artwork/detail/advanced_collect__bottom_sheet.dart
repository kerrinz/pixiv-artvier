import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/api_app/api_illusts.dart';
import 'package:pixgem/common_provider/loading_request_provider.dart';
import 'package:pixgem/common_provider/works_provider.dart';
import 'package:pixgem/component/filter/stateless_flow_filter.dart';
import 'package:pixgem/component/loading/request_loading.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/model_response/illusts/artwork_collect_detail.dart';

/// 高级收藏的弹窗，支持插画漫画小说
class AdvancedCollectBottomSheet extends StatefulWidget {
  /// 是否已经收藏了
  final bool isCollected;

  /// 作品id
  final String worksId;

  /// 作品类型，仅支持[WorksType.illust],[WorksType.manga],[WorksType.novel]
  final WorksType worksType;

  const AdvancedCollectBottomSheet({
    Key? key,
    required this.isCollected,
    required this.worksId,
    required this.worksType,
  })  : assert(worksType == WorksType.illust || worksType == WorksType.manga || worksType == WorksType.novel),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _AdvancedCollectBottomSheetState();
}

class _AdvancedCollectBottomSheetState extends State<AdvancedCollectBottomSheet> {
  CancelToken _cancelToken = CancelToken();

  /// 添加新标签的输入控制器
  late TextEditingController _addTagTextController;

  final FocusNode _addTagFocusNode = FocusNode();

  /// 标签列表
  final List<WorksCollectTag> _tags = [];

  /// 加载状态
  LoadingStatus _loadingStatus = LoadingStatus.loading;

  /// 是否已收藏
  late bool _isCollected;

  /// 作品的隐私限制
  String? _restrict;

  /// 最大附加标签数
  static const _maxTags = 10;

  /// 选择了多少个标签
  int _selectCount = 0;

  late StateSetter _countSetState;

  @override
  void initState() {
    _isCollected = widget.isCollected;
    _addTagTextController = TextEditingController();
    requestTags();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.6;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height
            ? MediaQuery.of(context).size.height
            : height,
      ),
      child: SafeArea(
        child: Column(
          children: [
            // 标题栏
            Row(
              children: [
                IconButton(onPressed: () => Navigator.pop(context, null), icon: const Icon(Icons.close_rounded)),
                Expanded(
                  child: Center(
                    child: Builder(builder: (context) {
                      return Text(_isCollected
                          ? LocalizationIntl.of(context).editCollection
                          : LocalizationIntl.of(context).addToCollections);
                    }),
                  ),
                ),
                IconButton(
                  onPressed: _loadingStatus == LoadingStatus.success
                      ? () {
                          List<String> attachTags = [];
                          for (var item in _tags) {
                            if ((item.isRegistered ?? false) && item.name != null) attachTags.add(item.name!);
                          }
                          Navigator.pop(
                            this.context,
                            AdvancedCollectArguments(
                                restrict: _restrict ?? CONSTANTS.restrict_public,
                                isCollected: _isCollected,
                                tags: attachTags),
                          );
                        }
                      : null,
                  icon: Row(
                    children: [
                      Icon(_isCollected ? Icons.check_outlined : Icons.favorite_outline_rounded),
                    ],
                  ),
                ),
              ],
            ),
            // restrict / 隐私限制
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      LocalizationIntl.of(context).privacyRestrict,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: Builder(builder: (filterContent) {
                      return StatelessTextFlowFilter(
                        selectedDecoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        unselectedTextStyle:
                            TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(200)),
                        texts: [LocalizationIntl.of(context).public, LocalizationIntl.of(context).private],
                        textPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                        initialIndexes: {CONSTANTS.restrict_private == _restrict ? 1 : 0},
                        onTap: ((_) {
                          _restrict = _restrict == CONSTANTS.restrict_private
                              ? CONSTANTS.restrict_public
                              : CONSTANTS.restrict_private;
                          (filterContent as Element).markNeedsBuild();
                        }),
                      );
                    }),
                  ),
                ],
              ),
            ),
            // 分隔线
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceVariant),
              child: const SizedBox(height: 2, width: double.infinity),
            ),
            // 附加标签
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      LocalizationIntl.of(context).attachTags,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                  StatefulBuilder(
                    builder: ((context, StateSetter theSetState) {
                      _countSetState = theSetState;
                      return Text("$_selectCount / $_maxTags");
                    }),
                  ),
                ],
              ),
            ),
            // 输入添加新的标签
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
              child: TextField(
                controller: _addTagTextController,
                focusNode: _addTagFocusNode,
                maxLines: 1,
                scrollPadding: EdgeInsets.zero,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  hintText: LocalizationIntl.of(context).addNewTagPlaceholder,
                  hintMaxLines: 1,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  isCollapsed: true, // 高度包裹，不会存在默认高度
                ),
                onSubmitted: ((value) {
                  if (LoadingStatus.success != _loadingStatus || value.isEmpty) return;
                  bool isNotExist = _tags.every(((element) => element.name != _addTagTextController.text));
                  if (isNotExist) {
                    setState(() {
                      _tags.insert(0, WorksCollectTag(name: value, isRegistered: true));
                      _selectCount++;
                      _addTagTextController.text = "";
                    });
                  } else {
                    Fluttertoast.showToast(msg: LocalizationIntl.of(context).tagAlreadyExists);
                  }
                  _addTagFocusNode.unfocus();
                }),
              ),
            ),
            // 标签列表
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                child: Builder(builder: (context) {
                  if (_loadingStatus == LoadingStatus.loading) {
                    return const RequestLoading();
                  } else if (_loadingStatus == LoadingStatus.failed) {
                    return RequestLoadingFailed(onRetry: () {
                      requestTags();
                    });
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: ((itemContext, index) {
                      return _TagListItemWidget(
                        name: _tags[index].name ?? "Error",
                        isRegistered: _tags[index].isRegistered ?? false,
                        onTap: () {
                          if (_tags[index].isRegistered ?? false) {
                            _tags[index].isRegistered = false;
                            _countSetState(() => _selectCount--);
                          } else {
                            if (_selectCount >= _maxTags) return;
                            _tags[index].isRegistered = true;
                            _countSetState(() => _selectCount++);
                          }
                          (itemContext as Element).markNeedsBuild();
                        },
                      );
                    }),
                    itemCount: _tags.length,
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 获取标签列表
  void requestTags() {
    if (!_cancelToken.isCancelled) _cancelToken.cancel();
    _cancelToken = CancelToken();
    switch (widget.worksType) {
      case WorksType.illust:
        ApiIllusts().getIllustCollectionTags(widget.worksId).then((value) {
          _tags.clear();
          for (WorksCollectTag item in value.detail?.tags ?? []) {
            if (item.isRegistered ?? false) _selectCount++;
          }
          setState(() {
            _tags.addAll(value.detail?.tags ?? []);
            _isCollected = value.detail?.isBookmarked ?? _isCollected;
            _restrict = value.detail?.restrict ?? CONSTANTS.restrict_public;
            _loadingStatus = LoadingStatus.success;
          });
        }).catchError((error) {
          if (error is DioError && error.type == DioErrorType.cancel) return;
        });
        break;
      case WorksType.manga:
        break;
      case WorksType.novel:
      default:
    }
  }

  @override
  void dispose() {
    if (!_cancelToken.isCancelled) _cancelToken.cancel();
    _addTagFocusNode.unfocus();
    _addTagTextController.dispose();
    super.dispose();
  }
}

/// 标签列表从的标签项
class _TagListItemWidget extends StatelessWidget {
  /// 标签名
  final String name;

  /// 是否被选择
  final bool isRegistered;

  final Function onTap;

  const _TagListItemWidget({
    required this.name,
    required this.isRegistered,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        splashFactory: InkSparkle.splashFactory,
        splashColor: colorScheme.background,
        highlightColor: colorScheme.background,
        onTap: () => onTap(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "#$name",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: isRegistered ? FontWeight.w600 : FontWeight.normal,
                      color: isRegistered ? colorScheme.primary : colorScheme.onSurface),
                ),
              ),
              Icon(
                isRegistered ? Icons.check_circle_rounded : Icons.circle_outlined,
                color: isRegistered ? colorScheme.primary : colorScheme.onSurface.withAlpha(50),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 高级收藏弹窗的回传数据模型
class AdvancedCollectArguments {
  String restrict;
  List<String> tags;
  bool isCollected;

  AdvancedCollectArguments({required this.restrict, required this.isCollected, required this.tags});
}
