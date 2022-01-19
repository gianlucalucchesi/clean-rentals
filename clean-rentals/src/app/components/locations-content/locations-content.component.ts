import { Component } from '@angular/core';

// https://github.com/DefinitelyTyped/DefinitelyTyped/issues/48574#issuecomment-711411465
@Component({
  selector: 'app-locations-content',
  templateUrl: './locations-content.component.html',
  styleUrls: ['./locations-content.component.css']
})
export class LocationsContentComponent {
  locations = [
    { lat: 50.849823, lng: 4.449186 }, // EPHEC Wolumé
    { lat: 50.900858, lng: 4.485482 }, // Brussels Airport
    { lat: 50.462460, lng: 4.458815 }, // Brussels South Airport
    { lat: 49.009633, lng: 2.547951 }, // Paris Charles de Gaulle Airport
    { lat: 52.309835, lng: 4.762879 }, // Amsterdam Airport Schiphol
  ];

  constructor() { }

}
