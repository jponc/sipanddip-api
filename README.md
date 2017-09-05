# Sip And Dip API

This is a Rails API for [Sip & Dip](https://www.facebook.com/sipanddipmnl/)

## Description

I built this project so Sip & Dip can easily keep track of their day-to-day operations including sales and inventory management.

- Hosted at [Heroku](https://heroku.com)
- Uses [UptimeRobot](https://uptimerobot.com/) for scheduled ping (so Herokuapp doesn't die!)
- Notifications directly to Sip & Dip's [Slack](https://slack.com/) platform
- Seamless integration with [Google Sheets](https://docs.google.com/spreadsheets/u/0/)

## Flow

1. Store manager updates Sip & Dip's Google Sheet on a daily basis before 11PM PH time
2. This app connects to Google sheet and retrieves the latest data
3. Store new set of data in db
4. Release a Slack notification

##

Built by [@jponc](https://github.com/jponc).
