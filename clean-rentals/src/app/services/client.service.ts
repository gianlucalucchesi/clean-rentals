import { HttpClient } from '@angular/common/http';
import { Injectable, OnInit } from '@angular/core';
import { Client } from '../models/client.model';
import { environment } from '../../environments/environment';
import { Observable, take } from 'rxjs';
import { AuthService } from '@auth0/auth0-angular';

@Injectable({
  providedIn: 'root',
})
export class ClientService implements OnInit {
  constructor(private http: HttpClient, private auth: AuthService) {}

  ngOnInit(): void {}

  getClientByAuth0Id$(auth0id: string): Observable<Client> {
    return this.http.get<Client>(
      environment.ApiUrl + 'v1/client/private/auth0/' + auth0id
    );
  }

  //stackoverflow.com/a/42185519/10470183
  getClient(): Promise<Client> {
    return new Promise((resolve) => {
      this.auth.user$.pipe(take(1)).subscribe({
        next: (user) => {
          this.getClientByAuth0Id$(user.sub)
            .pipe(take(1))
            .subscribe({
              next: (client) => resolve(client),
            });
        },
      });
    });
  }

  addNewClient(auth0id: string, auth0email: string) {
    let client = new Client();
    client.auth0Id = auth0id;
    client.emailAddress = auth0email;

    return this.http.post(environment.ApiUrl + 'v1/client/private', client);
  }

  updateClient(client: Client) {
    return this.http.put(environment.ApiUrl + 'v1/client/private', client);
  }
}
