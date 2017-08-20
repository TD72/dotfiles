#!/usr/bin/perl

$latex    = 'platex -synctex=1 %O %S';
# $pdflatex    = 'pdflatex';
# $pdftex = 'pdftex --output-format=pdf';
$bibtex   = 'pbibtex %O %S';
# $dvipdf   = 'dvips %O %S';
$dvipdf   = 'dvipdfmx %O %S';
# $dvipdf   = 'dvipdfmx -f ~/.fontsmap/ipa.map %O %S';
#
$pvc_view_file_via_temporary = 0;

$pdf_mode = 3;

if ($^O eq 'darwin') {
    $pdf_previewer = "open -ga Skim";
    # $pdf_update_method = 4;
    # $pdf_update_command = './images/png2eps';
} elsif ($^O eq 'linux') {
    $pdf_update_command = 'qpdfview';
    $pdf_previewer = "qpdfview --unique";
}
