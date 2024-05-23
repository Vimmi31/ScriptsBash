#Faça uma lista telefônica, que tenha as seguintes funcionalidades:#
#	1) Adicionar novos contatos(Com Id(gerado automaticamente), Nome, Telefone, CPF)
#	2) Consultar contatos

function inicio(){

local cam=""
#read -e -p "Digite um caminho para o arquivo " cam
cam="/home/vimmi/ScriptsBash/"
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

echo ${Cont[Id]}¨${Cont[Nome]}¨${Cont[Telefone]}¨${Cont[CPF]} >> $arq
[[ $? -ne 0 ]] && echo "Algo deu errado ao adicionar o Contato, Saindo..." exit 1
}

function ConsCont(){
    clear
    PS3="Selecione como você deseja fazer a busca: "
    opcoes=('Por nome' 'Por ID' 'Voltar ao menu')
    select opc in "${opcoes[@]}"; do
        case $REPLY in
            1)
                echo "Opção por nome"
                ;;
            2)  
                echo "Opção por ID"
                ;;
            3)
                echo "Voltando ao menu"
                Menu
                ;;
            *)
                echo "Opção inválida"
                ;;
        esac
    done
}



function Menu(){
    clear

    PS3="Olá! O que deseja realizar?"
    opcoes=('Adicionar contato' 'Consultar Contato' 'SAIR')
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
                echo "SAINDO"
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

#Fazer Consulta de contatos
