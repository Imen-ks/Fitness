# Fitness Application

## Features

### Recording a workout
Three different activities are available for recording: running, walking and cycling.  
A timer allows to start, pause, resume and stop a workout.  
Throughout the workout, a map is displayed with the path drawn on it. A banner displays measures such as distance and speed in real-time.

### Activity History
The History tab displays a list of the past records sorted by date with most recent workouts first. The list can be filtered by activity type.  
The detailed view of a record displays a map with the path taken during the workout as well as the start and end points. It also provides information such as the duration, the total distance, the average speed and the step counts.  

### Statistics
The Statistics tab displays three bar charts tracking distance travelled, calories burned and steps taken over time. The values can be shown by week, month and year.  
In addition to global statistics, the user has access to a calendar with daily achievements in the form of donut charts.

### Setting daily goals
The user has the ability to set its daily goals in terms of distance, calories and step counts in the Goals tab.

## Usage

Open the `Fitness.xcodeproj` file with Xcode and build the application in the simulator or on a device.  
Allow access to position and motion data when prompted.  
To simulate a location on the simulator, select **Features** menu > **Location**, then chose between a `City Run` or a `City Bicycle Ride`.

> [!NOTE]
> Pedometer simulation is not available. Pedometer values can only be fetched when the app is built on a real device.

-------
## Technologies

The app uses the `Core Location` and the `Core Motion` frameworks to gather real-time data about the path taken during the fitness workout. The data is persisted with `Core Data`.
All these services are managed through custom classes that can be found under the folder `/Services`. The `Combine` framework is used in the view models to subscribe to these services and update the views.
The app is also using `MapKit` and `Swift Charts` to render this data visually.

### Core Location

The LocationManager custom class handles location-related updates.  
To do so, it instantiates a `CLLocationManager` object that enables to start and stop location services. It reports all location-related updates to its delegate object, which is an object that conforms to the `CLLocationManagerDelegate` protocol.  
The app implements the delegate methods to handle both authorization status changes and locations updates.

#### Authorization status
Location data being sensitive information, it requires an [authorization request](https://developer.apple.com/documentation/corelocation/requesting_authorization_to_use_location_services) which is done in the app when the user first attempts to record a workout.  
In addition, the app includes the `Location When In Use Usage Description` key in the Info.plist and provides a description string to be displayed to the user.  
The app will display a Location Services Disabled error and prompt the user to change the device settings and enable Location Services if the location access is denied.

#### Locations updates
The app registers for [location updates](https://developer.apple.com/documentation/corelocation/handling_location_updates_in_the_background) in the background by setting the `allowsBackgroundLocationUpdates` property to `true` and by adding the `Background Modes` capability and enabling the `Location updates` option. This will update the Info.plist accordingly.  
When a user starts to record a workout, the LocationManager calls the `startUpdatingLocation()` method and gets location data stored in an array of CLLocation objects. These objects provide information such as latitude, longitude, distance, speed, altitude… All of them being stored in the LocationManager custom class for publishing during the workout and saving when finished.  
The `stopUpdatingLocation()` method is called when a user finishes or cancels a workouts.

### Core Motion
Core Motion reports motion-related data from the available onboard hardware. 
Same as for Core Location, the use of this API is subject to authorization request.  
The app includes the `Motion Usage Description` key in the Info.plist file and provides a usage description string for this key. This description appears in the prompt that the user must accept the first time the system asks to access motion data for the app, i.e. the first time the user attempts to record a workout.

The app is instantiating a `CMPedometer` object for fetching the system-generated live data. It uses it to retrieve the user’s step counts during a walking or a running workout.  
To do so, the app implements the `queryPedometerData(from:to:withHandler:)` method and calls it throughout the workout to get step counts taken for the elapsed time.
The latest step counts value is then stored when the user finishes the workout.

### Core Data
Core Data is used as a data persistence tool to store and retrieve all the data related to recorded workouts.  
The CoreDataManager custom class handles the Core Data Stack of the application. It defines a `persistenceController` property which is a struct holding a `NSPersistentContainer` instance in charge of setting up the model, context, and store coordinator simultaneously.  
The custom class handles CRUD operations on the database. It defines methods to fetch data and store them in variables ready to be published when needed as well as methods to save, add and delete data.  
Additionaly, it implements convenience methods for model conversion.

> [!NOTE]
> In addition to Core Data, the app is using `UserDefaults` to store the user goals.
-------
### Combine
Combine is widely used in the app whether it is to `assign` received event values or to `subscribe` to `publishers`.  
The LocationManager defines two publishers to provide updated distance and speed values throughout a workout.  
The Timer is a publisher for seconds elapsed that is used when recording a workout. The app subscribes to elapsedTime to query pedometer data and it then subscribes to MotionManager to update the step counts values during the workout.  
Finally, the app subscribes to the CoreDataManager published properties and uses methods to convert the NSManagedObjects into their respective Model.  
Apart from subscribing to publishers, Combine is also used in the view models to directly assign values retrieved from the services providers.

### MapKit
The app uses MapKit to retrieve the user’s location and to draw in real-time the path taken during a workout as well as the start and finish points.  
Two different MapViews are available depending on the iOS version installed on the device.

For iOS 17.0 and higher, the app will implement MapKit features built for SwiftUI and will use:
- `MapCameraBounds` to set the region
- `MapPolyline` to draw the path
- `Annotation` to mark the start and the finish points.

For lower versions, the app will use `UIViewRepresentable` protocol to wrap a UIKit View and use it in SwiftUI.  
The view is made using `MKCoordinateRegion`, `MKPolyline` and `MKPointAnnotation`.

### Swift Charts
Swift Charts are used, in the detailed view of a workout to display measures variations towards the distance.  
An `Area Chart` is used to display the average pace throughout a workout and a `Line Chart` displays the altitude changes.  
Additionally, `Bar Charts` display cumulated statistics for measures which goals can be set up. The data is grouped by date and can be show by week, month and year.  
For each measure, a `Rule Mark` shows the achievements towards respective goals.
