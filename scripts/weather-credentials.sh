#!/usr/bin/bash
# @see https://github.com/mnpqraven/dotfiles/blob/development/Scripts/nas-setup.sh
echo "Credentials gen script WeatherAPI"
file=$HOME/.config/hyprpanel/weather.json

echo -e "Enter WeatherAPI key"
read key
touch $file
echo "{ \"weather_api_key\": \"$key\" }"| tee $file
chmod 600 $file
echo "file created at $file"
