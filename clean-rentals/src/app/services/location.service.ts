import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root',
})
export class LocationService {
  location: Location;

  constructor(private http: HttpClient) {}

  getLocations$() {
    return this.http.get(environment.ApiUrl + 'v1/location');
  }
}
