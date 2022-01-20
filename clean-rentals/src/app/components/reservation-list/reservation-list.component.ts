import { Component, OnInit, Output } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { AuthClientConfig, AuthService } from '@auth0/auth0-angular';
import { take } from 'rxjs';
import { Reservation } from 'src/app/models/reservation.model';
import { ClientService } from 'src/app/services/client.service';
import { ReservationService } from 'src/app/services/reservation.service';

@Component({
  selector: 'app-reservation-list',
  templateUrl: './reservation-list.component.html',
  styleUrls: ['./reservation-list.component.css']
})
export class ReservationListComponent implements OnInit {
  audience = this.configFactory.get()?.audience;
  reservations: Reservation[];
  auth0Id: string;
  clientId: string;
  error: string;
  @Output() selectedReservationId: string;

  constructor(
    public auth: AuthService,
    private reservationService: ReservationService,
    private clientService: ClientService,
    private configFactory: AuthClientConfig,
    private router: Router,
    private route: ActivatedRoute
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

  onSelectReservation(index: number) {
    this.reservationService.setCurrentReservationId(this.reservations[index].id);
    this.router.navigate([this.reservations[index].id], { relativeTo: this.route });
  }
}
