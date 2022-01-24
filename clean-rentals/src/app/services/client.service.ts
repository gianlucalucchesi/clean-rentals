import { HttpClient } from '@angular/common/http';
import { Injectable, OnInit } from '@angular/core';
import { Client } from '../models/client.model';
import { environment } from '../../environments/environment';
import { AuthService, User } from '@auth0/auth0-angular';
import { Observable, Subscription, take } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class ClientService implements OnInit {
  currentClient: Client;

  constructor(private http: HttpClient, private auth: AuthService) {}

  ngOnInit(): void { }

  getClientByAuth0Id$(auth0id: string): Observable<Client> {
    return this.http.get<Client>(
      environment.ApiUrl + 'v1/client/private/auth0/' + auth0id
    );
  }

  addNewClient(auth0id: string, auth0email: string) {
    let client = new Client();
    client.auth0Id = auth0id;
    client.emailAddress = auth0email;

    return this.http.post(environment.ApiUrl + 'v1/client/private', client);
  }
}
