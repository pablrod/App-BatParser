use strict;
use warnings;
use utf8;

use Test::More tests => 1;
use English qw( -no_match_vars );
use App::BatParser;
use Path::Tiny;

{
    my $ast_expected = {

          'File' => {
                      'Lines' => [
                                   {
                                     'Statement' => {
                                                      'Command' => {
                                                                     'SpecialCommand' => {
                                                                                           'Echo' => {
                                                                                                       'EchoModifier' => 'off'
                                                                                                     }
                                                                                         }
                                                                   }
                                                    }
                                   },
                                   {
                                     'Statement' => {
                                                      'Command' => {
                                                                     'SimpleCommand' => 'cp file1 file2'
                                                                   }
                                                    }
                                   },
                                   {
                                     'Statement' => {
                                                      'Command' => {
                                                                     'SpecialCommand' => {
                                                                                           'Goto' => {
                                                                                                       'Identifier' => 'label'
                                                                                                     }
                                                                                         }
                                                                   }
                                                    }
                                   },
                                   {
                                     'Statement' => {
                                                      'Command' => {
                                                                     'SpecialCommand' => {
                                                                                           'Echo' => {
                                                                                                       'Message' => 'Never get executed'
                                                                                                     }
                                                                                         }
                                                                   }
                                                    }
                                   },
                                   {
                                     'Label' => {
                                                  'Identifier' => 'label'
                                                }
                                   },
                                   {
                                     'Comment' => {
                                                    'Text' => 'Comment with : especial characters and keywords: if, goto, set...'
                                                  }
                                   },
                                   {
                                     'Comment' => {
                                                    'Text' => 'Alternative form of comment'
                                                  }
                                   },
                                 ]
                    }
            };
    my $cmd_file = $PROGRAM_NAME;
    $cmd_file =~ s/\.t/\.cmd/;
    my $cmd_contents = path($cmd_file)->slurp;
    my $parser = App::BatParser->new;
    my $ast = $parser->parse($cmd_contents);

    is_deeply($ast, $ast_expected, 'Simple cmd');
}

