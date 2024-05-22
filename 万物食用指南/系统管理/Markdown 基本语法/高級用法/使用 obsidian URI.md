Obsidian 支援自定義的 URI 協議 `Obsidian://`，這個協議可以用來觸發 Obsidian 內部的各種動作。自定義 URI 協議通常用於 MacOS 中的跨應用程式工作流。

如果你已經安裝了 Obsidian，下面這個命令將在目前裝置上打開 Obidian：[點選此處](obsidian://open)

## 安裝 Obsidian URI

爲了讓你的操作系統將 `obsidian://` URI 重定向到 Obsidian，你可能需要執行一些額外的步驟。

- 對於 Windows，執行一次 Obsidian 就足夠了。因為這會在 Windows 註冊表中註冊 `obsidian://` 自定義協議處理程式。
- 對於 MacOS，執行一次 Obsidian 也足夠了。但需要注意的是，Obsidian 版本必須為 0.8.12 或更高。
- 對於 Linux，則需要更多的步驟：
		- 首先，確保你建立了一個 `obsidian.desktop` 檔案。[你可以在此獲得更多相關資訊](https://developer.gnome.org/integration-guide/stable/desktop-files.html.en)
		- 確保你的桌面檔案將 `Exec` 欄位指定為 `Exec=executable %u`。`%u` 將用於傳遞 `obsidian://` URI 給 Obsidian。
		- 如果你正在使用 AppImage 安裝程式，你可能需要使用 `Obsidian-x.y.z.AppImage --appimage-extract` 來解壓它。然後確保 `Exec` 指向解壓出來的可執行檔案。


## 使用 Obsidian URI

Obsidian URI 通常採用以下形式：

```
obsidian://action?param1=value&param2=value
```

-  `action` 表示你想讓 Obsidian 執行的動作。

### 編碼

==這部分非常重要==

你需要確保 URI 中的值是正確編碼的。比如，正斜線字元 `/` 必須編碼為 `%2F`，空格字元必須編碼為 `%20`。這一點特別重要，因為不符合規範的 URI 將不能正常執行。[想要了解更多編碼規範請點選此處](https://en.wikipedia.org/wiki/Percent-encoding)

### 可使用的動作

#### `open` 動作

動作描述：在 Obsidian 中打開一個庫，甚至打開庫內的某個檔案。

可能用到的參數：

- `vault` 既可以使用庫名稱，也可以使用庫 ID。
	- 庫名稱就是庫資料夾的名稱。
	- 庫 ID 是每個庫獨有的、隨機編碼的 16 位字串。比如：`ef6ca3e3b524d22f`。目前沒有簡單的方法來找到這些 ID，我們日後會開發相關的功能。目前庫 ID 可以在以下路徑找到：
		- 對於 Windows，路徑為 `%appdata%/obsidian/obsidian.json`
		- 對於 MacOS，則把 `%appdata%` 替換為 `~/Library/Application Support/`
		- 對於 Linux，把 `%appdata%` 替換為 `~/.config/`。
- `file` 既可以使用檔名稱，也可以使用基於庫的根目錄的檔案路徑。
	- 爲了獲取目標檔案，Obsidian 使用了與 `[[Wiki鏈接]]` 一樣的定位規則。
	- 如果副檔名是 `md`，可以省略副檔名。
- `path` 則是檔案在系統中的絕對路徑。
	- 這個參數將會覆蓋 `vault` 和 `file` 參數。
	- 參數執行時，Obsidian 先會搜索包含特定路徑的庫，隨後再在庫中尋找相關的檔案。即相當於先執行 `vault`，再執行 `file`。


示例:

- `obsidian://open?vault=my%20vault`
	這將打開名為 `my vault` 的庫。如果該庫已經打開，則讓焦點回到該庫上。

- `obsidian://open?vault=ef6ca3e3b524d22f`
	這將打開 ID 為 `ef6ca3e3b524d22f` 的庫。

- `obsidian://open?vault=my%20vault&file=my%20note`
	假設有一個名為 `my vault` 的庫，並且庫中包含 `my note.md` 這樣一條筆記的話，這將打開該筆記。

- `obsidian://open?vault=my%20vault&file=my%20note.md`
	這也會打開 `my vault` 庫中名為 `my note` 的筆記。

- `obsidian://open?vault=my%20vault&file=path%2Fto%2Fmy%20note`
	這將打開 `my vault` 庫中路徑為 `path/to/my note` 的筆記。

- `obsidian://open?path=%2Fhome%2Fuser%2Fmy%20vault%2Fpath%2Fto%2Fmy%20note` 這將讓 Obsidian 查詢包含路徑 `/home/user/my vault/path/to/my note` 的庫。隨後，路徑參數的剩餘部分將傳遞給 `file` 參數。這就好比在一個路徑為 `/home/user/my vault` 的庫中將 `file` 參數設定為 `path/to/my note` 一樣。

- `obsidian://open?path=D%3A%5CDocuments%5CMy%20vault%5CMy%20note`
	這將讓 Obsidian 尋找包含路徑 `D:\Documents\My vault\My note` 的庫。隨後，路徑參數的剩餘部分將傳遞給 `file` 參數。這就好比在一個路徑為 `D:\Documents\My vault` 的庫中將 `file` 參數設定為 `My note` 一樣。
	
#### `search` 動作

描述：打開 Obsidian 中某個庫的查詢面板，然後執行搜索（是否執行搜索是可選的）。

可能用到的參數：

- `vault` 既可以是庫名稱，也可以是庫 ID，這和 `open` 動作里一樣。
- `query` 用於設定要執行的搜索。這是可選參數。

示例：

- `obsidian://search?vault=my%20vault`
	這將打開名為 `my vault` 的庫，然後打開該庫的查詢面板。

- `obsidian://search?vault=my%20vault&query=MOC`
	這將打開名為 `my vault` 的庫，然後打開該庫的查詢面板，並搜索 `MOC`。
	
#### `new` 動作

描述：在庫中建立一篇新筆記，併爲筆記寫入一些內容（可選）。

可能用到的參數：

- `vault` 既可以是庫名稱，也可以是庫 ID，這和 `open` 動作里一樣。
- `name` 用於指定建立的筆記名稱。新筆記的存放位置受設定中 `新建筆記的存放位置` 選項控制。
- `file` 通過基於庫的絕對路徑來建立筆記。這將覆蓋 `name` 的設定。
- `path` 通過全域性的絕對路徑來建立筆記，這和 `open` 動作中的一樣。該參數將覆蓋 `vault` 和 `file` 的設定。
- `content` 指定新筆記中的內容，該參數非必須。
- `silent` 如果你不想打開新筆記，則設定此參數。

示例：

-`obsidian://new?vault=my%20vault&name=my%20note\` 這將打開名為 `my vault` 的庫，並建立一篇名為 `my note` 的新筆記。
-`obsidian://new?vault=my%20vault&path=path%2Fto%2Fmy%20note` 這將打開名為 `my vault` 的庫，並在 `path/to/my note` 路徑下建立一篇名為 `my note` 的新筆記。

#### `hook-get-address` 動作

描述：與 [Hook](https://hookproductivity.com/) 配合使用的動作，即複製目前筆記的 URI 到剪貼簿，即點選該 URI 后自動產生一個 `open` 目前筆記的 URI 並複製到剪貼簿。使用方式： `obsidian://hook-get-address`。

可能用到的參數：

- `vault` 用於指定庫，可以是庫名稱也可以是庫 ID。此參數非必須。如果不指定此參數，動作將指向目前或上次打開的庫。

## 簡寫形式

除了上述形式之外，你還可以使用兩種簡寫形式來打開庫或檔案：

- `obsidian://vault/my vault/my note` 這等同於 `obsidian://open?vault=my%20vault&file=my%20note`
- `obsidian:///absolute/path/to/my note` 這等同於 `obsidian://open?path=%2Fabsolute%2Fpath%2Fto%2Fmy%20note`
