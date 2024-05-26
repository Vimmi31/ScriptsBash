opcoes=("op1" "op2" "op3")
PS3="Selecione a opção"
select op in ${opcoes[@]}; do
    echo $op
    case $op in 
        1) 
            echo "Essa é a primeira opção";;
        2) 
            echo "Essa é a segunda opção";;
        3)
             echo "Essa é a terceira opção";;
    esac
done