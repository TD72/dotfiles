#!/usr/bin/perl

$latex    = 'platex -synctex=1 %O %S';
$bibtex   = 'pbibtex %O %S';
$dvipdf   = 'dvipdfmx -f ~/.fontsmap/ipa.map %O %S';

$pdf_mode = 3;
$pdf_update_command = 'qpdfview';
$pdf_previewer = "qpdfview --unique"
