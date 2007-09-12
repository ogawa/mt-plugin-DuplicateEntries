# DuplicateEntries
#
# $Id$
#
# This software is provided as-is. You may use it for commercial or 
# personal use. If you distribute it, please keep this notice intact.
#
# Copyright (c) 2007 Hirotaka Ogawa

package MT::Plugin::DuplicateEntries;
use strict;
use base qw(MT::Plugin);

use MT;
use MT::Entry;
use MT::Page;
use MT::Placement;
use MT::Template;

our $VERSION = '0.02';

my $plugin = __PACKAGE__->new({
    id => 'duplicate_entries',
    name => 'DuplicateEntries',
    description => q(<MT_TRANS phrase="DuplicateEntries plugin allows you to duplicate Movable Type entries, pages, and templates.">),
    doc_link => 'http://code.as-is.net/wiki/DuplicateEntries',
    author_name => 'Hirotaka Ogawa',
    author_link => 'http://profile.typekey.com/ogawa/',
    version => $VERSION,
    l10n_class => 'DuplicateEntries::L10N',
});
MT->add_plugin($plugin);

sub init_registry {
    my $plugin = shift;
    $plugin->registry({
	applications => {
	    cms => {
		list_actions => {
		    entry => {
			duplicate_entry => {
			    label      => $plugin->translate('Duplicate Entries'),
			    code       => \&duplicate_entries,
			    permission => 'create_post',
			},
		    },
		    page => {
			duplicate_page => {
			    label      => $plugin->translate('Duplicate Pages'),
			    code       => \&duplicate_entries,
			    permission => 'create_post',
			},
		    },
		    template => {
			duplicate_template => {
			    label      => $plugin->translate('Duplicate Templates'),
			    code       => \&duplicate_templates,
			    permission => 'edit_templates',
			},
		    },
		},
	    },
	},
    });
}

sub duplicate_entries {
    my $app = shift;
    my $perms = $app->permissions;
    return $app->trans_error('Permission Denied.')
	unless $perms && $perms->can_create_post;

    my $type = $app->param('_type') || 'entry';
    my $class = MT->model($type);

    my @entry_ids = $app->param('id')
	or return $app->error($plugin->translate('No entry was selected to duplicate.'));
    for my $entry_id (@entry_ids) {
	my $entry = $class->load($entry_id)
	    or return $app->error($plugin->translate('Invalid entry_id'));
	my $entry_cloned = $entry->clone({
	    except => {
		id       => 1,
		basename => 1,
		atom_id  => 1,
		tangent_cache => 1,
	    },
	});
	$entry_cloned->status(MT::Entry::HOLD());
	$entry_cloned->tags($entry->tags);

	$entry_cloned->save
	    or return $app->error($plugin->translate('Saving entry failed: [_1]', $entry_cloned->errstr));

	my @places = MT::Placement->load({ entry_id => $entry->id });
	for my $place (@places) {
	    my $place_cloned = $place->clone({
		except => {
		    id => 1,
		},
	    });
	    $place_cloned->entry_id($entry_cloned->id);
	    $place_cloned->save
		or return $app->error($plugin->translate('Saving placement failed: [_1]', $place_cloned->errstr));
	}
    }

    $app->call_return;
}

sub duplicate_templates {
    my $app = shift;
    my $perms = $app->permissions;
    return $app->trans_error('Permission Denied.')
	unless $perms && $perms->can_edit_templates;

    my $type = 'template';
    my $class = MT->model($type);

    my @tmpl_ids = $app->param('id')
	or return $app->error($plugin->translate('No template was selected to duplicate.'));
    for my $tmpl_id (@tmpl_ids) {
	my $tmpl = $class->load($tmpl_id)
	    or return $app->error($plugin->translate('Invalid template_id'));
	my $tmpl_cloned = $tmpl->clone({
	    except => {
		id       => 1,
	    },
	});
	$tmpl_cloned->name(make_unique_tmpl_name($tmpl));
	$tmpl_cloned->save
	    or return $app->error($plugin->translate('Saving template failed: [_1]', $tmpl_cloned->errstr));
    }

    $app->call_return;
}

sub make_unique_tmpl_name {
    my $tmpl = shift;
    my $blog_id = $tmpl->blog_id;
    my $tmpl_name = $tmpl->name;
    my $unique_tmpl_name;
    my $i = 1;
    do {
	$unique_tmpl_name = $tmpl_name . ' (' . $i++ . ')';
    } while (MT->model('template')->count({
	name    => $unique_tmpl_name,
	blog_id => $blog_id
    }));

    $unique_tmpl_name;
}

1;
