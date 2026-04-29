$start = Get-Date "2024-03-01"
$end   = Get-Date "2028-12-01"

$current = $start

if (!(Test-Path "json")) {
    New-Item -ItemType Directory -Path "json" | Out-Null
}

while ($current -le $end) {

    $folderName = $current.ToString("yyyy-MM")
    $folderPath = Join-Path "json" $folderName

    if (!(Test-Path $folderPath)) {
        New-Item -ItemType Directory -Path $folderPath | Out-Null
    }

    # יצירת map-title.json אם לא קיים
    $titleFile = Join-Path $folderPath "map-title.json"

    if (!(Test-Path $titleFile)) {

        $hebrewMonth = switch ($current.Month) {
            1 {"ינואר"}
            2 {"פברואר"}
            3 {"מרץ"}
            4 {"אפריל"}
            5 {"מאי"}
            6 {"יוני"}
            7 {"יולי"}
            8 {"אוגוסט"}
            9 {"ספטמבר"}
            10 {"אוקטובר"}
            11 {"נובמבר"}
            12 {"דצמבר"}
        }

        $titleContent = @{
            title = "מפת יעלים לחודש  — $hebrewMonth $($current.Year)"
        } | ConvertTo-Json -Depth 2

        Set-Content -Path $titleFile -Value $titleContent -Encoding UTF8
    }

    # placeholder ל-geojson
    $geoFile = Join-Path $folderPath "period.geojson"

    if (!(Test-Path $geoFile)) {
        Set-Content -Path $geoFile -Value "" -Encoding UTF8
    }

    $current = $current.AddMonths(1)
}
