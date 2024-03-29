import { Component, OnInit, Output } from '@angular/core';
import { AuthService } from '@auth0/auth0-angular';
import { take } from 'rxjs';
import { Reservation } from 'src/app/models/reservation.model';
import { ClientService } from 'src/app/services/client.service';
import { ReservationService } from 'src/app/services/reservation.service';

@Component({
  selector: 'app-reservation-content',
  templateUrl: './reservation-content.component.html',
  styleUrls: ['./reservation-content.component.css'],
})
export class ReservationContentComponent implements OnInit {
  @Output() reservations: Reservation[];
  auth0Id: string;
  clientId: string;
  error: string;

  constructor(
    public auth: AuthService,
    private reservationService: ReservationService,
    private clientService: ClientService
  ) {}

  ngOnInit(): void {
    this.auth.user$.pipe(take(1)).subscribe({
      next: (user) => {
        this.auth0Id = user.sub;

        this.clientService
          .getClientByAuth0Id$(this.auth0Id)
          .pipe(take(1))
          .subscribe({
            next: (client) => {
              this.clientId = client.id;
              this.getReservations();
            },
          });
      },
    });
  }

  getReservations() {
    this.reservationService.getClientReservations$(this.clientId).subscribe({
      next: (res) => {
        this.error = null;
        let responseJson = JSON.stringify(res, null, 2).trim();
        this.reservations = JSON.parse(responseJson);
        // Most recent on top
        this.reservations = this.reservations
          .slice()
          .sort((a: any, b: any) => b.dateTimeStart - a.dateTimeStart)
          .filter((res) => res.paid && !res.cancelled);
      },
      error: (err) => {
        this.error = err.error.error;
        this.reservations = [];
      },
    });
  }
}
