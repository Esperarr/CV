# CV

这个仓库现在只保留一套清晰入口：

- `cv/current/`：当前正式简历，中英文源文件和编译好的 PDF 都放在这里。
- `cv/archive/`：历史版本。两页版在 `rhodes-2026/`，其他旧版在 `previous/`。
- `materials/`：申请材料和证明文件，不放进公开网页目录。
- `docs/`：简历个人主页的 Markdown 源码和公开资源。
- `site/`：由 `docs/` 生成的网页快照，不要直接改这里的简历源文件。

## 当前正式版

- 英文：`cv/current/CV_en.tex` → `cv/current/CV_en.pdf`
- 中文：`cv/current/CV_zh.tex` → `cv/current/CV_zh.pdf`

## 修改流程

1. 只修改 `cv/current/CV_en.tex` 或 `cv/current/CV_zh.tex`。
2. 在仓库根目录运行下列任一命令：

   ```powershell
   # 中英文全部编译
   .\build.ps1

   # 只编译英文
   .\build.ps1 -Target en

   # 只编译中文
   .\build.ps1 -Target zh
   ```

3. 打开 `cv/current/` 中生成的 PDF 检查排版。编译中间文件位于
   `cv/current/build/`，包括 `.aux`、`.log`、`.fls` 等；这些文件已被
   `.gitignore` 排除，可以随时重新生成。
4. 需要更新个人主页时，再运行 `mkdocs build`。简历 PDF 会自动复制到
   `docs/assets/cv/` 供网页下载。

不要直接改 PDF。具体内容应始终从对应 `.tex` 文件重新编译。

## 归档规则

- 只把正在用于投递的版本放在 `cv/current/`。
- 有特殊页数或格式要求的申请结束以后，把整套 `.tex`、`.pdf` 和样式文件移入
  `cv/archive/<用途-年份>/`，并写一句为什么保留。
- 不要把 transcript、语言成绩、SOP 等私人材料复制到 `docs/` 或 `site/`。

## 编译环境

英文版使用 `pdflatex`，中文版使用 `xelatex`；两者都由 `latexmk` 自动运行。
仓库根目录的 `build.ps1` 只是一层方便调用的包装脚本，内部仍是分别调用
`latexmk`。脚本默认保留 `cv/current/build/` 中的编译日志，便于排查错误。
