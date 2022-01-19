import { Component, OnDestroy, OnInit } from '@angular/core';
import { AuthClientConfig, AuthService } from '@auth0/auth0-angular';
import { Subscription, take } from 'rxjs';
import { Client } from 'src/app/models/client.model';
import { Reservation } from 'src/app/models/reservation.model';
import { ClientService } from 'src/app/services/client.service';
import { ReservationService } from 'src/app/services/reservation.service';

@Component({
  selector: 'app-manage-reservations',
  templateUrl: './manage-reservations.component.html',
  styleUrls: ['./manage-reservations.component.css'],
})
export class ManageReservationsComponent implements OnInit {
  // responseJson: string;
  audience = this.configFactory.get()?.audience;
  reservations: Reservation[];
  auth0Id: string;
  clientId: string;
  error: string;

  constructor(
    public auth: AuthService,
    private reservationService: ReservationService,
    private clientService: ClientService,
    private configFactory: AuthClientConfig
  ) {}

  ngOnInit(): void {
    this.auth.user$.pipe(take(1)).subscribe((user) => {
      this.auth0Id = user.sub;

      this.clientService
      .getClientByAuth0Id$(this.auth0Id)
      .pipe(take(1))
      .subscribe((client) => {
        this.clientId = client.id;
        this.getReservations();
      });

    });
  }

  getReservations() {
    this.reservationService.getReservation$(this.clientId).subscribe({
      next: (res) => {
        this.error = null;
        let responseJson = JSON.stringify(res, null, 2).trim();
        this.reservations = JSON.parse(responseJson);
      },
      error: (err) => {
        this.error = err.error.error;
      },
    });
  }

}
