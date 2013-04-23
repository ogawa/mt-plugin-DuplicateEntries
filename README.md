# DuplicateEntriesプラグイン

エントリーやウェブページやテンプレートを複製するためのプラグイン。

 - [Download](https://github.com/ogawa/mt-plugin-DuplicateEntries/archive/master.zip)

## 概要

DuplicateEntriesプラグインは、MT CMSの「ブログ記事の一覧」画面、「ウェブページの一覧」画面、「ブログのテンプレート」画面から、選択したアイテムをコピーして新しいブログ記事・ウェブページ・テンプレートを作る機能を実現します。複製されたアイテムは「下書き」状態である点を除いてオリジナルのアイテムの完全な複製となります。

Movable Type 4.0以降の機能を利用して実現しているため、3.xでは動作しません。

## 使い方

プラグインをインストールするには、パッケージに含まれるDuplicateEntriesディレクトリをMovable Typeのプラグインディレクトリ内にアップロードもしくはコピーしてください。正しくインストールできていれば、Movable Typeのメインメニューにプラグインが新規にリストアップされます。

「ブログ記事」の複製を作る場合には、

 * 「ブログ記事の一覧」画面を開いて一個以上のアイテムを選択する。
 * 「アクション…」リストから「ブログ記事の複製」を選択して「Go」をクリックする。

「ウェブページ」や「テンプレート」の場合も同様です。

複製されたブログ記事ないしウェブページは「下書き」状態で保存されます。公開する場合には「ブログ記事の一覧」画面から「ブログ記事の公開」を行うか、「ブログ記事の編集」画面から「公開状態」を「公開」に変更して「保存」してください。

## TODO

## 更新履歴

 - 0.01 (2007-09-06 21:55:17 +0900):
   - 一年半くらい前に作ったのをMT4用にお化粧して、公開。
 - 0.02 (2007-09-13 11:44:40 +0900):
   - テンプレートの複製も作れるようにしました。

## License

This code is released under the Artistic License. The terms of the Artistic License are described at [http://www.perl.com/language/misc/Artistic.html](http://www.perl.com/language/misc/Artistic.html).

## Author & Copyright

Copyright 2007, Hirotaka Ogawa (hirotaka.ogawa at gmail.com)
