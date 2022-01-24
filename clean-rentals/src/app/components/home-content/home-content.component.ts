import { Component, OnInit } from '@angular/core';
import { AuthService } from '@auth0/auth0-angular';
import { faLink } from '@fortawesome/free-solid-svg-icons';
import { take } from 'rxjs';
import { Client } from 'src/app/models/client.model';
import { ClientService } from 'src/app/services/client.service';

@Component({
  selector: 'app-home-content',
  templateUrl: './home-content.component.html',
  styleUrls: ['./home-content.component.css'],
})
export class HomeContentComponent implements OnInit {
  faLink = faLink;

  constructor(
    private auth: AuthService,
    private clientService: ClientService
  ) {}

  ngOnInit(): void {
    this.auth.isAuthenticated$.pipe(take(1)).subscribe((isAuthenticated) => {
      if (isAuthenticated) {
        this.auth.user$.pipe(take(1)).subscribe((user) => {
          this.clientService
            .getClientByAuth0Id$(user.sub)
            .pipe(take(1))
            .subscribe({
              next: () => {
                // Nothing to do because client exists in database
              },
              error: (err) => {
                this.clientService
                  .addNewClient(user.sub, user.email)
                  .pipe(take(1))
                  .subscribe();
              },
            });
        });
      }
    });
  }
}
