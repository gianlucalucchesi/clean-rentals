import { HttpClient } from '@angular/common/http';
import { Injectable, OnInit } from '@angular/core';
import { Client } from '../models/client.model';
import { environment } from '../../environments/environment';
import { AuthService } from '@auth0/auth0-angular';
import { Observable, Subscription } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ClientService {
  currentClient: Client;

  constructor(private http: HttpClient, private auth: AuthService) { }

  getClientByAuth0Id$(auth0id: string): Observable<Client> {
    return this.http.get<Client>(environment.ApiUrl + 'v1/client/private/auth0/' + auth0id);
  }
}
