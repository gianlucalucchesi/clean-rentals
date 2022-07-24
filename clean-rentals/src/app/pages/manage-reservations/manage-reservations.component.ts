import { Component, OnDestroy, OnInit } from '@angular/core';
import { AuthClientConfig, AuthService } from '@auth0/auth0-angular';
import { Subscription } from 'rxjs';
import { ReservationService } from 'src/app/services/reservation.service';
@Component({
  selector: 'app-manage-reservations',
  templateUrl: './manage-reservations.component.html',
  styleUrls: ['./manage-reservations.component.css'],
})
export class ManageReservationsComponent implements OnInit, OnDestroy {
  reservationId: string;
  subscription: Subscription;

  constructor(
    public auth: AuthService,
    public reservationService: ReservationService
  ) {}

  ngOnInit(): void {
    this.subscription = this.reservationService.currentReservationId$.subscribe(
      (id) => (this.reservationId = id)
    );
  }

  ngOnDestroy(): void {
    this.subscription.unsubscribe();
  }
}
