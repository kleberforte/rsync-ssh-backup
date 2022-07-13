UARIOLOCAL=meuusuario
SSHID=/home/$USUARIOLOCAL/.ssh/id_rsa
USUARIOREMOTO=usuario
# Domínio ou IP
SERVIDOR=dominio.com
PORTA=2224

ORIGEM=/home/$USUARIOREMOTO/pasta
PRAONDE=`pwd`/pastaBackups
NAOCOPIAR=`pwd`/naocopiar.list
LOG=`pwd`/pastaBackups/logs

# RSYNC + SSH
rsync -avzR --delete --progress --exclude-from="$NAOCOPIAR" --log-file="$LOG/backup-`date +%d.%m.%y-%H.%M`.log" -e "ssh -p $PORTA -i $SSHID" $USUARIO@$SERVIDOR:$ORIGEM "$PRAONDE"

chmod 640 $LOG/*.log

# -a : Archive mode – Recursiva e preserva links simbólicos, arquivos especiais de dispositivo, hora de modificação, o grupo, proprietário e permissões;
# -v : Aumenta a verbosidade;
# -z : Comprime os dados durante a transferência;
# -R : Preserva o caminho completo;
# --delete : Exclui arquivos no diretório de destino se eles não existirem no diretório de origem;
# --progress : Mostra o progresso durante a transferência;
# --exclude-from : Excluir lista de diretorios/arquivos da tarefa de sincronização;
# --log-file : Gera arquivo de log.

