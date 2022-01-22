import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { take } from 'rxjs';
import { Car } from 'src/app/models/car.model';
import { CarService } from 'src/app/services/car.service';

@Component({
  selector: 'app-car-details',
  templateUrl: './car-details.component.html',
  styleUrls: ['./car-details.component.css'],
})
export class CarDetailsComponent implements OnInit {
  car: Car;

  constructor(private route: ActivatedRoute, private carService: CarService) {}

  ngOnInit(): void {
    // https://angular-training-guide.rangle.io/routing/child_routes
    this.route.params.subscribe((params) => {
      this.carService
        .getCarById$(params['id'])
        .pipe(take(1))
        .subscribe((car) => {
          let json = JSON.stringify(car);
          this.car = JSON.parse(json);
        });
    });
  }

}
