import { Component, Input, OnInit } from '@angular/core';
import { Car } from 'src/app/models/car.model';

@Component({
  selector: 'app-cars',
  templateUrl: './cars.component.html',
  styleUrls: ['./cars.component.css']
})
export class CarsComponent implements OnInit {
  @Input() car: Car

  constructor() { }

  ngOnInit(): void {
  }

}
