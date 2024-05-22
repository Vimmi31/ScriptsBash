#Faça uma lista telefônica, que tenha as seguintes funcionalidades:#
#	1) Adicionar novos contatos(Com Id, Nome, Telefone, CPF)
#	2) Consultar contatos

function inicio(){

local cam=""
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

function addCont(){
declare -A Cont

for i in "Id" "Nome" "Telefone" "CPF"; do
    read -p "Qual o ${i} do contato?" Cont[$i]
    #Enquanto a cariavel estiver vazia, vai pedir para o useuario a preeencher
    while [[ -z ${Cont[$i]} ]]; do 
        read -p "Qual o ${i} do contato?" Cont[$i]
    done
done

#fazer o redirecionamento para o arquivo criado!
    
}

addCont