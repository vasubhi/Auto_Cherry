echo 'Antes de Continuar, certifique-se que não possui nenhum arquivo no git status que não queira submeter.'
echo 'Digite o número da OS:'
read -p "-> " number_os
echo 'Comentário:'
read -p "-> " comments
echo 'Digite o(s) número(s) da(s) Versão(ões):    -- OBS: Em casos de múltiplas versões, separe com espaços.'
	read -p "-> " -a number_version
echo 'Digite o(s) Hashe(s):   -- OBS: Em casos de múltiplos hashes, separe com espaços.'
	read -p "-> " -a hash
for i in ${number_version[@]}
do
	echo "Trocando para branch ${i}"
	git checkout ${i} 
	echo "Atualizando Branch ${i}"
	git pull origin ${i}
	echo "Criando branch ${i}_${number_os}"
	git checkout -b ${i}_${number_os} 
	for j in ${hash[@]}
	do
		echo "Adicionado Cherry-Pick do hash ${j}"
		git cherry-pick ${hash}
	done
	echo "Criando Commit: [SO - ${number_os}] ${comments}"
	git commit -m "[SO - ${number_os}] ${comments}"
	echo "Realizando Push"
	git push origin ${i}_${number_os}
done
echo "Script finalizado!"
