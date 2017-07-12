function pd() {
    if [ $# = 0 ]; then
        echo "pd [filen_name].tex"
    else
        tex_name=$1
        file_name=${tex_name%.*}
        dvi_name="${file_name}.dvi"
        platex $1 && dvipdfmx $dvi_name
    fi
}


function pdo() {
    if [ $# = 0 ]; then
        echo "pd [filen_name].tex"
    else
        tex_name=$1
        file_name=${tex_name%.*}
        dvi_name="${file_name}.dvi"
        pdf_name="${file_name}.pdf"
        platex $1 && dvipdfmx $dvi_name && open $pdf_name
    fi
}
