# Script to fix dbt internal package files by adding profile
# Run this after dbt deps or other operations that regenerate internal packages

$profile = "data_pipeline"
$files = @(
    "dbt_internal_packages\dbt-adapters\dbt_project.yml",
    "dbt_internal_packages\dbt-snowflake\dbt_project.yml"
)

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw
        if ($content -notmatch "profile:") {
            # Add profile if it doesn't exist
            if ($content -match "name:") {
                $content = $content -replace "(name:.*)", "`$1`nprofile: $profile"
            } else {
                $content = "name: dbt`nprofile: $profile`n"
            }
            [System.IO.File]::WriteAllText((Resolve-Path $file), $content, [System.Text.UTF8Encoding]::new($false))
            Write-Host "Fixed: $file"
        } else {
            Write-Host "Already has profile: $file"
        }
    }
}

