#!/usr/bin/perl

$latex    = 'platex -synctex=1 %O %S';
$bibtex   = 'pbibtex %O %S';
$dvipdf   = 'dvipdfmx %O %S';
# $dvipdf   = 'dvipdfmx -f ~/.fontsmap/ipa.map %O %S';

$pdf_mode = 3;

if ($^O eq 'darwin') {
    # $pdf_update_command = 'skitch';
    $pdf_previewer = "open -a Skim"
} elsif ($^O eq 'linux') {
    $pdf_update_command = 'qpdfview';
    $pdf_previewer = "qpdfview --unique"
}
