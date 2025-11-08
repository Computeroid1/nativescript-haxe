package examples;

import ns.ui.*;
import ns.core.*;

typedef WeatherData = {
    city:String,
    temperature:Float,
    condition:String,
    humidity:Int,
    windSpeed:Float
}

class WeatherApp {
    private static var weatherData:State<Null<WeatherData>>;
    private static var cityInput:State<String>;
    private static var isLoading:State<Bool>;
    private static var errorMessage:State<String>;
    
    public static function main() {
        weatherData = new State<Null<WeatherData>>(null);
        cityInput = new State<String>("");
        isLoading = new State<Bool>(false);
        errorMessage = new State<String>("");
        
        weatherData.subscribe(function(_) updateUI());
        cityInput.subscribe(function(_) updateUI());
        isLoading.subscribe(function(_) updateUI());
        errorMessage.subscribe(function(_) updateUI());
        
        App.run(buildUI());
    }
    
    private static function updateUI():Void {
        App.update(buildUI());
    }
    
    private static function buildUI():VNode {
        return new ScrollView(
            new VStack([
                buildHeader(),
                buildSearchSection(),
                buildErrorSection(),
                buildWeatherDisplay(),
                buildFooter()
            ])
            .padding(16)
            .background("#E3F2FD")
        )
        .toVNode();
    }
    
    private static function buildHeader():Component {
        return new VStack([
            new Text("⛅ Weather App")
                .font(36, "bold")
                .foregroundColor("#1976D2")
                .padding(16),
            
            new Text("Check weather in any city")
                .font(14)
                .foregroundColor("#666666")
        ])
        .padding(16);
    }
    
    private static function buildSearchSection():Component {
        return new VStack([
            new TextField("Enter city name...", cityInput)
                .padding(12)
                .background("#FFFFFF")
                .cornerRadius(8)
                .frame(null, 48),
            
            new Button(isLoading.get() ? "Searching..." : "Get Weather", function() {
                if (!isLoading.get()) {
                    fetchWeather();
                }
            })
            .padding(12)
            .background(isLoading.get() ? "#BDBDBD" : "#2196F3")
            .foregroundColor("#FFFFFF")
            .cornerRadius(8)
            .frame(null, 48),
            
            if (isLoading.get()) {
                new ActivityIndicator(true)
                    .padding(16);
            } else {
                new Spacer();
            }
        ])
        .padding(16)
        .background("#FFFFFF")
        .cornerRadius(12)
        .shadow(4, 0.2);
    }
    
    private static function buildErrorSection():Component {
        var error = errorMessage.get();
        if (error.length == 0) {
            return new Spacer();
        }
        
        return new Text(error)
            .font(14)
            .foregroundColor("#F44336")
            .padding(16)
            .background("#FFEBEE")
            .cornerRadius(8);
    }
    
    private static function buildWeatherDisplay():Component {
        var weather = weatherData.get();
        if (weather == null) {
            return new VStack([
                new Text("🌍")
                    .font(64)
                    .padding(32),
                new Text("Enter a city to see weather")
                    .font(16)
                    .foregroundColor("#999999")
            ]);
        }
        
        return new VStack([
            new Text(weather.city)
                .font(28, "bold")
                .foregroundColor("#1976D2")
                .padding(8),
            
            new Text(getWeatherEmoji(weather.condition))
                .font(80)
                .padding(16),
            
            new Text('${Math.round(weather.temperature)}°C')
                .font(48, "bold")
                .foregroundColor("#333333")
                .padding(8),
            
            new Text(weather.condition)
                .font(20)
                .foregroundColor("#666666")
                .padding(4),
            
            new Divider(),
            
            new HStack([
                buildWeatherDetail("💧", "Humidity", '${weather.humidity}%'),
                buildWeatherDetail("💨", "Wind", '${weather.windSpeed} km/h')
            ])
            .padding(16)
        ])
        .padding(24)
        .background("#FFFFFF")
        .cornerRadius(16)
        .shadow(6, 0.3);
    }
    
    private static function buildWeatherDetail(emoji:String, label:String, value:String):Component {
        return new VStack([
            new Text(emoji)
                .font(32)
                .padding(4),
            new Text(label)
                .font(12)
                .foregroundColor("#999999"),
            new Text(value)
                .font(16, "bold")
                .foregroundColor("#333333")
        ])
        .padding(12);
    }
    
    private static function buildFooter():Component {
        return new Text("Data updates every search")
            .font(12)
            .foregroundColor("#999999")
            .padding(16);
    }
    
    private static function fetchWeather():Void {
        var city = cityInput.get().trim();
        if (city.length == 0) {
            errorMessage.set("Please enter a city name");
            return;
        }
        
        isLoading.set(true);
        errorMessage.set("");
        
        // Simulate API call with mock data
        #if js
        js.Syntax.code("setTimeout(function() {
            {0}({
                city: {1},
                temperature: Math.random() * 30 + 5,
                condition: ['Sunny', 'Cloudy', 'Rainy', 'Snowy'][Math.floor(Math.random() * 4)],
                humidity: Math.floor(Math.random() * 40 + 40),
                windSpeed: Math.random() * 20 + 5
            });
        }, 1500)", mockWeatherCallback, city);
        #end
    }
    
    private static function mockWeatherCallback(data:WeatherData):Void {
        isLoading.set(false);
        weatherData.set(data);
    }
    
    private static function getWeatherEmoji(condition:String):String {
        return switch(condition) {
            case "Sunny": "☀️";
            case "Cloudy": "☁️";
            case "Rainy": "🌧️";
            case "Snowy": "❄️";
            default: "🌤️";
        };
    }
}