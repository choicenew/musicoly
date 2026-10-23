# Hetu Script Plugin Standard Template (河图沙盒插件标准模板与规约)

## 0. 核心定位
将数据源、抓取规则或三方 API 封装为基于 Hetu Script 沙盒虚拟机的独立插件包。

---

## 1. 插件标准文件结构
每个 Hetu 插件目录必须包含以下两个文件：

```text
packages/sample_plugins/<plugin_name>/
├── manifest.json                   # 插件元数据声明
└── source.ht                       # Hetu 脚本入口文件
```

### 1.1 `manifest.json` 格式规范
```json
{
  "id": "org.pyromagma.source.<source_id>",
  "name": "<Source Name>",
  "protocol": "hetu",
  "contentType": "wallpaper",        // 类型: wallpaper / comic / novel / academic
  "defaultLanguage": "zh",
  "version": "1.0.0",
  "entry": "source.ht",
  "description": "源描述与数据范围说明",
  "author": "PyroMagma OpenSource",
  "homepage": "https://example.com"
}
```

### 1.2 `source.ht` 标准模板与 Hook 契约
```hetu
import 'module:http' as http;
import 'module:host_webview' as webview;
import 'module:storage' as storage;

var HttpClient = http.HttpClient;
var HttpBaseOptions = http.HttpBaseOptions;

class Source {
  var id = 'org.pyromagma.source.example';
  var name = 'Example Source';
  var version = '1.0.0';
  var client;

  fun manifest() {
    return {
      'id': id,
      'name': name,
      'version': version,
      'contentType': 'wallpaper',
      'supportsSearch': true,
      'supportsExplore': true
    };
  }

  fun init(context) {
    var options = HttpBaseOptions(
      headers: {
        'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
        'accept': 'application/json'
      }
    );
    client = HttpClient(options);
  }

  fun getExploreConfig() {
    return [
      {'id': 'featured', 'title': '精选壁纸'},
      {'id': 'latest', 'title': '最新上线'}
    ];
  }

  async fun search(query, page, {config}) {
    if (client == null) init(null);
    var encodedQ = query.replaceAll(' ', '%20');
    // 执行网络请求并清洗拼装为标准 DTO Map
    return [];
  }

  async fun explore(category, page, {config}) {
    return await search(category, page, config: config);
  }

  async fun getDetail(contentId, {config}) {
    return {};
  }
}

export { Source }
```
