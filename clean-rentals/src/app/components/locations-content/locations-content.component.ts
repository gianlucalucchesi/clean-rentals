import { Component, OnInit } from '@angular/core';
import { take } from 'rxjs';
import { Location } from 'src/app/models/location.model';
import { LocationService } from 'src/app/services/location.service';

interface Ilocation {
  lat: number;
  lng: number;
  name: string;
}

// https://github.com/DefinitelyTyped/DefinitelyTyped/issues/48574#issuecomment-711411465
@Component({
  selector: 'app-locations-content',
  templateUrl: './locations-content.component.html',
  styleUrls: ['./locations-content.component.css'],
})
export class LocationsContentComponent implements OnInit {
  locations: Ilocation[] = [];
  startLocation = { lat: 50.849823, lng: 4.449186 }; // EPHEC Wolumé

  constructor(private locationService: LocationService) {}

  ngOnInit(): void {
    this.locationService
      .getLocations$()
      .pipe(take(1))
      .subscribe((locations) => {
        let json: string = JSON.stringify(locations);
        console.log(json);
        this.handleLocations(json);
      });
  }

  handleLocations(rawJson: string) {
    let locations: Location[] = JSON.parse(rawJson);

    for (let location of locations) {
      this.locations.push({
        lat: +location.latitude,
        lng: +location.longitude,
        name: location.name,
      });
    }
  }
}
