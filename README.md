Вот PowerShell-скрипт, который:

Удаляет все кэшированные устройства Bluetooth, включая Wireless Controller.

Чистит драйвера Sony / DualSense / HID, если они были установлены.

Перезапускает стек Bluetooth.

Даёт инструкции для ручного переподключения через классическое окно устройств.


Запуск:
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass & "$env:USERPROFILE\\Downloads\\ResetDualSenseBluetooth.ps1"
