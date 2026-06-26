# Push landing page prospects to Clay via HTTP API webhook
# Usage: .\push-to-clay.ps1 -WebhookUrl "https://api.clay.com/v1/sources/YOUR_WEBHOOK_ID"

param(
    [Parameter(Mandatory=$true)]
    [string]$WebhookUrl
)

$prospects = @(
    @{
        first_name       = "Sarah"
        last_name        = "Mitchell"
        email            = "sarah.mitchell@retool.com"
        title            = "VP of Revenue Operations"
        company          = "Retool"
        company_website  = "https://retool.com"
        linkedin_url     = "https://linkedin.com/in/sarahmitchell"
        personalized_url = "https://listiq-landing-pages.vercel.app/sarah-retool"
    },
    @{
        first_name       = "Marcus"
        last_name        = "Chen"
        email            = "marcus.chen@linear.app"
        title            = "Head of Growth"
        company          = "Linear"
        company_website  = "https://linear.app"
        linkedin_url     = "https://linkedin.com/in/marcuschen"
        personalized_url = "https://listiq-landing-pages.vercel.app/marcus-linear"
    },
    @{
        first_name       = "Emily"
        last_name        = "Rodriguez"
        email            = "emily.rodriguez@loom.com"
        title            = "Director of Sales Development"
        company          = "Loom"
        company_website  = "https://www.loom.com"
        linkedin_url     = "https://linkedin.com/in/emilyrodriguez"
        personalized_url = "https://listiq-landing-pages.vercel.app/emily-loom"
    },
    @{
        first_name       = "James"
        last_name        = "Okonkwo"
        email            = "james.okonkwo@webflow.com"
        title            = "GTM Engineer"
        company          = "Webflow"
        company_website  = "https://webflow.com"
        linkedin_url     = "https://linkedin.com/in/jamesokonkwo"
        personalized_url = "https://listiq-landing-pages.vercel.app/james-webflow"
    },
    @{
        first_name       = "Rachel"
        last_name        = "Goldstein"
        email            = "rachel.goldstein@airtable.com"
        title            = "VP of Sales"
        company          = "Airtable"
        company_website  = "https://www.airtable.com"
        linkedin_url     = "https://linkedin.com/in/rachelgoldstein"
        personalized_url = "https://listiq-landing-pages.vercel.app/rachel-airtable"
    }
)

Write-Host "Pushing $($prospects.Count) prospects to Clay..." -ForegroundColor Cyan

$success = 0
$failed  = 0

foreach ($prospect in $prospects) {
    $body = $prospect | ConvertTo-Json -Compress
    try {
        $response = Invoke-RestMethod -Uri $WebhookUrl -Method Post -Body $body -ContentType "application/json"
        Write-Host "  [OK] $($prospect.first_name) $($prospect.last_name) ($($prospect.company))" -ForegroundColor Green
        $success++
    } catch {
        Write-Host "  [FAIL] $($prospect.first_name) $($prospect.last_name): $($_.Exception.Message)" -ForegroundColor Red
        $failed++
    }
    Start-Sleep -Milliseconds 300
}

Write-Host ""
Write-Host "Done. $success succeeded, $failed failed." -ForegroundColor Cyan
