
//

#import "LocationController.h"
#import "AppDelegate.h"
//#import "Macro.h"

@implementation LocationController
@synthesize location;

static LocationController *sharedInstance;


+ (LocationController *)sharedController
{
    static LocationController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[self alloc] init];
    });
    
    return sharedController;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 30; // Meters.
        [_locationManager requestWhenInUseAuthorization];
    }
    return self;
}

+ (LocationController *)sharedInstance
{
    @synchronized(self)
    {
        if (!sharedInstance)
            sharedInstance=[[LocationController alloc] init];       
    }
    
    return sharedInstance;
}

+(id)alloc
{
    
    @synchronized(self)
    {
        NSAssert(sharedInstance == nil, @"Attempted to allocate a second instance of a singleton LocationController.");
        sharedInstance = [super alloc];
    }
    return sharedInstance;
}

-(void) start {
    [_locationManager startUpdatingLocation];
    self.location = [[CLLocation alloc] initWithLatitude:40.68906 longitude:-74.044636];
    
}

-(void) stop {
    [_locationManager stopUpdatingLocation];
}
-(BOOL) isLocationEnable
{
    if([CLLocationManager locationServicesEnabled])
        return TRUE;
    return FALSE;
}

-(BOOL) locationKnown { 
    if (round(location.speed) == -1)
        return NO; 
    else return YES; 
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
   
   // self.location = [[CLLocation alloc] initWithLatitude:40.68906 longitude:-74.044636];
   // [[self delegate] locationManager:self didUpdateToLocation:location fromLocation:nil];
    
   // [self.delegate locationControllerDidUpdateLocation:self.location];
    [self.delegate locationControllerDidUpdateLocation:locations.lastObject];
    [self setLocation:locations.lastObject];
}

/*
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
//    NSUserDefaults *checkCurrentLocation = [NSUserDefaults standardUserDefaults];
//    [checkCurrentLocation setObject:@"false" forKey:@"check"];
//    NSString *check = [checkCurrentLocation stringForKey:@"check"];
//    NSLog(@"%@",check);
    
    UIAlertView *alert;

    alert = [[UIAlertView alloc] initWithTitle:@"Error" message:NSLocalizedStringFromTable(@"Current Location disable", @"message", @"gpx") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];


}*/

- (void)locationManager: (CLLocationManager *)manager  didFailWithError: (NSError *)error
{
    [manager stopUpdatingLocation];
     NSLog(@"error%@",error);
   
    switch([error code])
    {
        case kCLErrorNetwork: // general, network-related error
        {
           // [appDelegate showAlertMessage:@"please check your network connection or that you are not in airplane mode"];
           
        }
            break;
        case kCLErrorDenied:
        {
            
            //[appDelegate showAlertMessage:@"user has denied to use current Location "];
        }
            break;
        default:
        {
            // [appDelegate showAlertMessage:@"unknown network error"];
        }
            break;
    }


}
-(NSString *)latitude
{
    return [NSString stringWithFormat:@"%f",self.location.coordinate.latitude];
}
-(NSString *)longitude
{
    return [NSString stringWithFormat:@"%f",self.location.coordinate.longitude];
}



@end