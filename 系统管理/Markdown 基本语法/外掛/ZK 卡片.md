開啟這個外掛后 Obsidian 的左邊欄將會增加一個按鈕，點選該按鈕你可以建立一篇以目前時間（Zettelkasten ID）為標題的筆記。如果你使用 Zettelkasten 方法的話，這將會是一個十分有用的外掛。

用該外掛建立的筆記標題預設為12位時間戳，如「202001010000」。你可以根據自己的需要進行調整。

### 模板

ZK 卡片外掛允許你為 ZK 卡片指定[[模板]]，這樣你就不需要重複調整 ZK 卡片的格式。使用模板以後，當你建立 ZK 卡片時，模板中的內容會複製到新建立的 ZK 卡片中。因此，通過模板，你可以輕鬆設定那些你經常都要用到的標籤或鏈接。

使用模板時，ZK 卡片和普通筆記存在一些差別：`{{date}}` 和 `{{time}}` 變數並不會被賦值。如果想要在 ZK 卡片中使用這兩個變數，需要以 `{{date:YYYY-MM-DD}}` 和 `{{time:HH:mm}}` 的形式寫在模板中。