import {
  Component,
  Input,
  OnChanges,
} from '@angular/core';
import { ChartType } from 'angular-google-charts';
import { Observable, take } from 'rxjs';
import { Client } from 'src/app/models/client.model';
import { Reservation } from 'src/app/models/reservation.model';
import { ReservationService } from 'src/app/services/reservation.service';

@Component({
  selector: 'app-chart',
  templateUrl: './chart.component.html',
  styleUrls: ['./chart.component.css'],
})
export class ChartComponent implements OnChanges {
  title = 'Your brand preferences';
  type = ChartType.PieChart;
  data: (string | number)[][] = [];

  options = {
    legend: {
      position: 'none',
    },
    pieSliceText: 'label',
    titlePosition: 'none', // Added as div in HTML
  };
  width = 400;
  height = 400;
  @Input() client: Client;
  reservations: Reservation[];

  constructor(private reservationService: ReservationService) {}

  // Wait for @Input() to change (= load)
  ngOnChanges(): void {
    if (this.client) {
      this.reservationService
        .getReservation$(this.client.id)
        .pipe(take(1))
        .subscribe((reservations) => {
          this.handleReservations(reservations);
        });
    }
  }

  handleReservations(reservations: Observable<Reservation>) {
    let json = JSON.stringify(reservations);
    this.reservations = JSON.parse(json);
    let brands: string[] = [];

    if (this.reservations) {
      for (let reservation of this.reservations) {
        if (!brands.includes(reservation.car.brand.name)) {
          brands.push(reservation.car.brand.name);
        }
      }

      for (let brand of brands) {
        let brandData: (string | number)[] = [];

        let count = 0;
        for (let reservation of this.reservations) {
          if (reservation.car.brand.name === brand) {
            count++;
          }
        }

        // Concatenation as workaround for showing value next to label in chart
        brandData.push(brand + ' (' + count + ')', count);
        this.data.push(brandData);
      }
    }
  }
}
