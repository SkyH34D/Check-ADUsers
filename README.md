# Check-ADUsers

![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue.svg?logo=powershell)
![Active Directory](https://img.shields.io/badge/Active%20Directory-RSAT-0078D4.svg?logo=windows)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![Purpose](https://img.shields.io/badge/Focus-Audit%20%2F%20IAM-orange.svg)

Herramienta en PowerShell para la verificación masiva del estado de habilitación (`Enabled`) de cuentas en Active Directory a partir de un listado de nombres de usuario (`SamAccountName`).

Diseñada para acelerar el triage durante auditorías de seguridad (ej. validación rápida de identidades tras hallazgos de contraseñas vacías, cuentas huérfanas o revisiones de acceso).

---

## ⚡ Características

* **Chequeo masivo:** Procesa un archivo de texto con un usuario por línea.
* **Manejo de errores:** Identifica cuentas existentes (`True`/`False`) y marca claramente las no encontradas (`NOT_FOUND`).
* **Salida limpia:** Omite líneas en blanco e interactúa con el pipeline de PowerShell.
* **Operación segura:** Solo realiza consultas de lectura (`Get-ADUser`) sin impacto en producción.

---

## 🛠️ Requisitos Previos

* **Windows PowerShell 5.1** o superior.
* **Módulo RSAT ActiveDirectory** instalado y permisos de lectura en el dominio.

---

## 🚀 Uso y Ejemplos

### Formato del archivo de entrada (`usuarios.txt`)
Crea un archivo `.txt` con un `SamAccountName` por línea:

```text
usuario1
usuario2
usuarioinexistente
```

### Ejecución básica
```powershell
.\Check-ADUsers.ps1 -Path .\usuarios.txt
```

### Ejemplo de salida

```text
SamAccountName     Enabled
--------------     -------
usuario1           False
usuario2           True
usuarioinexistente NOT_FOUND
```

---

## 📊 Exportación de Resultados

Como el script genera un array de objetos (`PSCustomObject`), puedes guardar el resultado para análisis o informes:

```powershell
# Guardar en variable y exportar a CSV
$Results = .\Check-ADUsers.ps1 -Path .\usuarios.txt
$Results | Export-Csv -Path .\Resultado_Auditoria.csv -NoTypeInformation -Encoding UTF8
```

---

## ⚙️ Instalación en el PATH de la sesión de usuario

Para poder ejecutar `Check-ADUsers.ps1` desde cualquier directorio de la consola sin especificar la ruta completa:

```powershell
$scriptDirectory = 'C:\Path\2\Tool'
$currentUserPath = [System.Environment]::GetEnvironmentVariable('Path', 'User')

if (($currentUserPath -split ';') -notcontains $scriptDirectory) {
    $newUserPath = $currentUserPath.TrimEnd(';') + ';' + $scriptDirectory
    [System.Environment]::SetEnvironmentVariable('Path', $newUserPath, 'User')
}
```
> *Nota: Reabre la consola de PowerShell tras ejecutar este bloque para refrescar las variables de entorno.*

---

## 🗺️ Roadmap

- [ ] Exportación automática a CSV opcional mediante parámetro.
- [ ] Filtrado rápido por parámetro (ej. `-OnlyDisabled`).
- [ ] Inclusión de fecha de último inicio de sesión (`LastLogonDate`).
- [ ] Mapeo de Unidad Organizativa (`OU`) de pertenencia.
- [ ] Generación de reportes en HTML.

---

## 👤 Autor

**Cristian Franco with Microsoft Copilot**

---

## 📜 Licencia

Este proyecto está bajo la Licencia [MIT](LICENSE).
