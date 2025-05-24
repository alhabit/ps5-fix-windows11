Вот PowerShell-скрипт, который:]\n
Удаляет все кэшированные устройства Bluetooth, включая Wireless Controller.\n
Чистит драйвера Sony / DualSense / HID, если они были установлены.\n
Перезапускает стек Bluetooth.\n
Даёт инструкции для ручного переподключения через классическое окно устройств.\n
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass & "$env:USERPROFILE\\Downloads\\ResetDualSenseBluetooth.ps1"\n
