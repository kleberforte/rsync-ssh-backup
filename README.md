# 🐧 Script RSYNC + SSH

#### Passo 1 - Gerar um par de chaves para configurar a autenticação baseada em chaves SSH

No terminal do servidor de origem, digite o seguinte comando:

```bash
ssh-keygen -t rsa
```

Foram gerados os seguintes arquivos:

`/home/meuusuario/.ssh/id_rsa`

`/home/meuusuario/.ssh/id_rsa.pub`

Corrija as permissões de acesso à chave privada:

```bash
chmod 600 /home/meuusuario/.ssh/id_rsa
```

#### Passo 2 - Copiar o conteúdo da chave pública para o servidor remoto

Execute o comando para copiar o conteúdo da chave pública `id_rsa.pub` para o caminho `/home/usuarioremoto/.ssh/authorized_keys` no servidor remoto:

```bash
ssh-copy-id usuario@dominio-ou-ip
```

**Obs.:** Nesse processo, a senha do usuário remoto será solicitada.

Corrija as permissões de acesso ao arquivo:

```bash
chmod 600 /home/usuarioremoto/.ssh/authorized_keys
```

#### Passo 3 - O Script 📃

Torne o arquivo executável:

```bash
chmod +x rsync-ssh-backup.sh
```

Agora é só executá-lo manualmente ou via Cron. 😉

##### Conteúdo do script

```bash
#!/bin/bash

USUARIOLOCAL=meuusuario
SSHID=/home/$USUARIOLOCAL/.ssh/id_rsa
USUARIOREMOTO=usuario
# URL ou IP
SERVIDOR=urldoclienteremoto.dominio.com
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
```
