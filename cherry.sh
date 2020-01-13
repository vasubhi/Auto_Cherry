echo 'Antes de Continuar, certifique-se que não possui nenhum arquivo no git status que não queira submeter.'
echo 'Digite o número da OS:'
read -p "-> " number_os
echo 'Comentário:'
read -p "-> " comments
echo 'Digite o(s) número(s) da(s) Versão(ões):    -- OBS: Em casos de múltiplas versões, separe com espaços.'
echo 'Exemplo: 3.05.1765 3.05.1764 3.05.1764'
	read -p "-> " -a array_version
echo 'Digite o(s) Hashe(s):   -- OBS: Em casos de múltiplos hashes, separe com espaços.'
	read -p "-> " -a array_hash
for version in ${array_version[@]}
do
	echo "Trocando para branch ${version}"
	git checkout ${version} 
	echo "Atualizando Branch ${version}"
	git pull origin ${version}
	echo "Criando branch ${version}_${number_os}"
	git checkout -b ${version}_${number_os} 
	for hash in ${array_hash[@]}
	do
		echo "Adicionado Cherry-Pick do hash ${hash}"
		git cherry-pick ${hash}
	done
	echo "Realizando Push"
	git push origin ${version}_${number_os}
done
echo "Script finalizado!"
