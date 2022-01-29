import { Component, Input, OnChanges, OnInit } from '@angular/core';
import { AuthService } from '@auth0/auth0-angular';
import { ChartType } from 'angular-google-charts';
import { Observable, take } from 'rxjs';
import { Client } from 'src/app/models/client.model';
import { Reservation } from 'src/app/models/reservation.model';
import { ClientService } from 'src/app/services/client.service';
import { ReservationService } from 'src/app/services/reservation.service';

@Component({
  selector: 'app-chart',
  templateUrl: './chart.component.html',
  styleUrls: ['./chart.component.css'],
})
export class ChartComponent implements OnInit, OnChanges {
  @Input() client: Client;
  reservations: Reservation[];

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

  constructor(
    private reservationService: ReservationService,
    private auth: AuthService,
    private clientService: ClientService
  ) {}

  ngOnInit(): void {}

  // Wait for @Input() to change then load
  ngOnChanges(): void {
    if (this.client) {
      this.reservationService
        .getClientReservations$(this.client.id)
        .pipe(take(1))
        .subscribe({
          next: (reservations) => this.handleReservations(reservations),
          error: () => (this.reservations = []),
        });

      this.auth.user$.pipe(take(1)).subscribe((profile) => {
        this.clientService
          .getClientByAuth0Id$(profile.sub)
          .pipe(take(1))
          .subscribe((client) => {
            next: this.client = client;
          });
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
