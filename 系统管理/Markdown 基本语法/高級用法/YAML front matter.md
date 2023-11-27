---
aliases: front matter
---

YAML，也被稱為 front matter，是位於檔案開頭、並用 `---` 標識的區域，用於表示檔案的元資訊。front matter 不僅可被計算機識別，也能被我們人類理解。

因 Jekyll、Hugo 和 Gatsby 等靜態產生器的存在，通過 Front matter 為 Markdown 檔案新增元資訊已經成爲了非常常見的方法。

Front matter 以 `---` 開頭，也以其結尾。需要注意的是，==它需要放置在檔案開頭才能被 Obsidian 或其他軟體識別。==

示例：

```
---
key: value
key2: value2
key3: [one, two, three]
key4:
- 4
- 5
- 6
---
```

從 0.12.12 版本起，Obsidian 支援四種原生鍵名：

- `tags` （詳情見[[標籤的使用]]）
- `aliases` （詳情見[[為筆記新增別名]]）
- `cssclass`
- `publish` （詳情見[[發佈#YAML 與發佈]]）

Obsidian 還在不斷成長。未來，我們將讓外掛開發者更容易呼叫 Front matter，同時也會讓 Front matter 對使用者更加友好。