﻿<#
    You should add the snippet below to your PS files to ensure that PsNuGet is available.
#>
function Ensure-PsNuGetLoaded{
    [cmdletbinding()]
    param($toolsDir = "$env:LOCALAPPDATA\LigerShark\psnuget\",
        $psNuGetDownloadUrl = 'https://raw.githubusercontent.com/sayedihashimi/publish-module/master/ps-nuget.psm1')
    process{
        if(!(Test-Path $toolsDir)){ New-Item -Path $toolsDir -ItemType Directory }

        $expectedPath = (Join-Path ($toolsDir) 'ps-nuget.psm1')
        if(!(Test-Path $expectedPath)){
            'Downloading [{0}] to [{1}]' -f $psNuGetDownloadUrl,$expectedPath | Write-Verbose
            (New-Object System.Net.WebClient).DownloadFile($psNuGetDownloadUrl, $expectedPath)
        }
        
        if(!$expectedPath){throw ('Unable to download ps-nuget.psm1')}

        if(get-module 'ps-nuget'){ Remove-Module 'ps-nuget' -Force }
        Import-Module $expectedPath -Force
    }
}