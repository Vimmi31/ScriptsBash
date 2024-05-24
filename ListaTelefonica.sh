#Faça uma lista telefônica, que tenha as seguintes funcionalidades:#
#	1) Adicionar novos contatos(Com Id(gerado automaticamente), Nome, Telefone, CPF)
#	2) Consultar contatos

function inicio(){

    cam=""
    read -e -p "Digite um caminho para o arquivo " cam
    #testa até a variavel cam ter um caminho valido
    while [[ ! -d "$cam" ]]; do 
        read -e -p "Digite um caminho para o arquivo " cam
    done
    arq="${cam}lista.txt"
    #testa se o arquivo de dados já existe, senão, cria ele, se sim não faz nada.
    [[ -e $arq ]] && echo "Os dados serão adicionados no arquivo que já existe " || echo "Criando o arquivo de dados" 
    >> $arq  
}

function geraId(){
    local Id=$(wc -l < "$arq")
    echo $Id
}

function addCont(){
    clear
    declare -A Cont

    for i in "Id" "Nome" "Telefone" "CPF"; do
        if [[ $i = "Id" ]]; then
            Cont[$i]=$(geraId)
            else
                read -p "Qual o ${i} do contato?" Cont[$i]
                #Enquanto a cariavel estiver vazia, vai pedir para o useuario a preeencher
                while [[ -z ${Cont[$i]} ]]; do 
                    read -p "Qual o ${i} do contato?" Cont[$i]
                done
        fi
    done
    #Salva os dados trocando todas as letras por minusculas(para facilitar manipulação dos dados)
    echo ${Cont[Id]} ${Cont[Nome]} ${Cont[Telefone]} ${Cont[CPF]} | tr 'A-Z' 'a-z' >> $arq 
    #Se por algum motivo, a gravação dos dados não funcionar, para o programa.
    [[ $? -ne 0 ]] && echo "Algo deu errado ao adicionar o Contato, Saindo..." exit 1
}

function ConsCont(){
    clear
    PS3="Selecione como você deseja fazer a busca: "
    opcoes=('Por nome' 'Por ID' 'Voltar ao menu')
    select opc in "${opcoes[@]}"; do
        case $REPLY in
            1) 
                read -p "Quem você deseja buscar? " pesq
                while [[ "$pesq" =~ [1-9] ]]; do ##Testa se na String tem numeros
                    clear
                    echo "Nome possui apenas letras, digite novamente"
                    read -p "Qual Id você deseja buscar? " pesq
                done
                cat $arq | grep "$pesq"
                #Se o termo buscado pelo user não existir, a mensagem é exibida
                [[ $? -ne 0 ]] && echo "Contato não existe" 
                read -p "Aperte enter para retornar ao menu de busca"
                ConsCont
                ;;
            2)
                read -p "Qual Id você deseja buscar? " pesq  

                while [[ "$pesq" =~ [a-zA-Z] ]]; do ##Testa se na String tem letras
                    clear
                    echo "Atenção o id possui apenas numeros, digite novamente"
                    read -p "Qual Id você deseja buscar? " pesq
                done
                cat $arq | grep "^$pesq"
                #Se o termo buscado pelo user não existir, a mensagem é exibida
                [[ $? -ne 0 ]] && echo "Id não existe" 
                read -p "Aperte enter para retornar ao menu de busca"
                ConsCont
                ;;
            3)
                echo "Voltando ao menu"
                Menu
                ;;
            *)
                ConsCont
                echo "Opção inválida"
                ;;
        esac
    done
}

function RemCont(){
    read -p "Diga qual o id do contato que deseja remover" id
    while [[ "$id" =~ [a-zA-Z] ]]; do ##Testa se na String tem letras
                    clear
                    echo "Atenção o id possui apenas numeros, digite novamente"
                    read -p "Qual Id você deseja remover? " id
                done

    sed "${id}d" $arq > temp.txt && mv  $arq && echo "Removido com sucesso" || echo "algo deu errado an remoção do contato"
    echo $cam
    read

}

function Menu(){
    clear

    PS3="Olá! O que deseja realizar?"
    opcoes=('Adicionar contato' 'Consultar Contato' 'Remover Contato' 'SAIR')
    select opc in "${opcoes[@]}"; do
        case $REPLY in
            1)
                addCont
                Menu
                ;;
            2)  
                ConsCont
                Menu
                ;;
            3)
                RemCont
                Menu
                ;;
            3)
                clear
                echo "SAINDO"
                sleep 1
                clear
                exit 0
                ;;
            *)
                echo "Opção inválida"
                Menu
                ;;
        esac
    done

}

inicio
sleep 2
Menu

#Arrumar a função de remover contato, mexi na função de Inicio
#Arrumar função de inicio, para testar se o caminho do arquivo está certo