import os

python_venv = ".pyenv/bin/python"
target_id   = 0x31100003
file_name   = "app.hex"
data_size   = 0x00000040    # `cat debug/app.map |grep _nvram_data_size | tr -s ' ' | cut -f2 -d' '`
icon_hex    = "0100000000ffffff001000800008004002000000050800220208000100840200100081020400200000"  # python $(BOLOS_SDK)/icon.py $(ICONNAME) hexbitmaponly
script_cmd  = "-m ledgerblue.loadApp --path \"44'/4218'\" --path \"44'/01'\" --appFlags 0x00 --tlv --targetId 0x%08X --delete --fileName %s --appName \"IOTA\" --appVersion 0.0.1 --dataSize 0x%08X --icon %s" % (target_id, file_name, data_size, icon_hex)

os.system("%s %s" % (python_venv, script_cmd))
