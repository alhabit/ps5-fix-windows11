
# Запуск от имени администратора обязателен
Write-Host "== Удаление кэшированных Bluetooth-устройств из реестра ==" -ForegroundColor Cyan
$btRegPath = "HKLM:\SYSTEM\CurrentControlSet\Services\BTHPORT\Parameters\Devices"
if (Test-Path $btRegPath) {
    Remove-Item "$btRegPath\*" -Recurse -Force
    Write-Host "Очищено: $btRegPath" -ForegroundColor Green
} else {
    Write-Host "Путь к Bluetooth-кэшу не найден." -ForegroundColor Yellow
}

Write-Host "`n== Поиск и удаление драйверов Sony, DualSense и HID ==" -ForegroundColor Cyan
$driverList = pnputil /enum-drivers | Select-String -Pattern "oem.*\.inf|Driver Name.*(Sony|DualSense|Wireless|HID|ViGEm|HidHide)"
$drivers = @()
for ($i = 0; $i -lt $driverList.Count; $i++) {
    if ($driverList[$i] -match "^Published Name.*(oem\d+\.inf)") {
        $oem = $Matches[1]
        $name = $driverList[$i+1] -replace "Driver Name.*?:\s*", ""
        $drivers += [PSCustomObject]@{ OEM = $oem; Name = $name }
    }
}

if ($drivers.Count -gt 0) {
    foreach ($d in $drivers) {
        Write-Host "Удаление $($d.Name) ($($d.OEM))" -ForegroundColor Magenta
        pnputil /delete-driver $($d.OEM) /uninstall /force | Out-Null
    }
    Write-Host "Все целевые драйверы удалены." -ForegroundColor Green
} else {
    Write-Host "Целевые драйверы не найдены." -ForegroundColor Yellow
}

Write-Host "`n== Перезапуск служб Bluetooth ==" -ForegroundColor Cyan
Restart-Service bthserv -Force
Start-Sleep -Seconds 3
Write-Host "Службы Bluetooth перезапущены." -ForegroundColor Green

Write-Host "`n== Инструкция ==" -ForegroundColor Cyan
Write-Host "1. Нажмите Win+R и введите: control /name Microsoft.DevicesAndPrinters" -ForegroundColor White
Write-Host "2. Включите режим сопряжения на DualSense (зажать PS + Create до белого мигания)." -ForegroundColor White
Write-Host "3. Нажмите 'Добавить устройство' и выберите Wireless Controller." -ForegroundColor White
Write-Host "4. Не трогайте мышку/клаву во время сопряжения." -ForegroundColor White
Write-Host "`n После успешного подключения вы сможете использовать геймпад во всех играх." -ForegroundColor Green
