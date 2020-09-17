echo 'Digite o número da OS:'
read -p "-> " number_os
echo 'Digite o(s) número(s) da(s) Versão(ões):    -- OBS: Em casos de múltiplas versões, separe com espaços.'
echo 'Exemplo: 3.05.1765 3.05.1764 3.05.1764'
while [[ -z "$array_version" ]]
do
	read -p "-> " -a array_version
done
echo 'Digite o(s) Hashe(s):   -- OBS: Em casos de múltiplos hashes, separe com espaços.'
echo '[NÃO ADICIONE HASHES DO TIPO MERGE]'
while [[ -z "$array_hash" ]]
do
	read -p "-> " -a array_hash
done
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
	read -p "Aperte enter para autorizar git push -> " kkk
	echo "Realizando Push"
	git push origin ${version}_${number_os}
done
echo "Script finalizado!"
