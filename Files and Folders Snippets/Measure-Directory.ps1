<#
    Splatting used for clarity
    This gets the sizes of folders in bytes (or MB/GB uncomment the rounding)
    Path -> Where you want to measure from
    Recurse -> Gets subdirectories too
    Depth -> How many subdirectories you want to go into
#>

$DirectoryParams = @{
    Path = "E:\"
    Recurse = $true
    Directory = $true
    Depth = 2
}

$FolderSizes = Get-ChildItem @DirectoryParams | ForEach-Object {
    $SizeParams = @{
    Path = $_.FullName
    Recurse = $true
    }
    
    $Size = (Get-ChildItem @SizeParams | Measure-Object -Property Length -Sum).Sum
    #$SizeInMB = [math]::Round($SizeInBytes / 1MB, 2)
    #$SizeInGB = [math]::Round($SizeInBytes / 1GB, 2)
    [PSCustomObject]@{
        Folder = $_.FullName
        Size = $Size
    }
}

$FolderSizes