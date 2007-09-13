# $Id$
package DuplicateEntries::L10N::ja;

use strict;
use base 'DuplicateEntries::L10N';
use vars qw( %Lexicon );

our %Lexicon = (
    'DuplicateEntries plugin allows you to duplicate Movable Type entries, pages, and templates.' => 'DuplicateEntriesプラグインを用いると、Movable Typeのブログ記事・ウェブページ・テンプレートを複製することができます。',
    'Duplicate Entries' => 'ブログ記事の複製',
    'Duplicate Pages' => 'ウェブページの複製',
    'Duplicate Templates' => 'テンプレートの複製',
    'Are you sure you want to duplicate the selected entries?' => '選択したブログ記事を複製してよろしいですか?',
    'Are you sure you want to duplicate the selected page(s)?' => '選択したウェブページを複製してよろしいですか?',
    'Are you sure you want to duplicate the selected template(s)?' => '選択したテンプレートを複製してよろしいですか?',
    'Saving entry failed: [_1]' => 'ブログ記事の保存に失敗しました: [_1]',
    'Saving placement failed: [_1]' => 'ブログ記事とカテゴリの関連付けを設定できませんでした: [_1]',
    'Saving template failed: [_1]' => 'テンプレートの保存に失敗しました: [_1]',
    'No entry was selected to duplicate.' => '複製するブログ記事が選択されていません。',
    'No template was selected to duplicate.' => '複製するテンプレートが選択されていません。',
    'Invalid entry_id' => '不正なentry_id',
    'Invalid template_id' => '不正なtemplate_id',
);

1;
