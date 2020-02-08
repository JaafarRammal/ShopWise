import json

from flask import Blueprint, Response, request, jsonify
import http.client, urllib.request, urllib.parse, urllib.error, base64

production_trace = Blueprint('production_trace', __name__)


class trace:
    def __init__(self, id):
        self.id = id
        self.origin = 'South Africa'
        self.trace = [
            {
                'Origin': 'South Africa',
                'Seller': 'Jeff\'s farm',
                'Type': 'Farmer',
                'Carbon footprint(CO2e)': '0.4',
                'Transport': 'Truck'
            },
            {
                'Origin': 'South Africa',
                'Seller': 'Tesco South Africa',
                'Type': 'Wholesaler',
                'Carbon footprint(tCO2e)': '5',
                'Transport': 'Ship'
            },
            {
                'Origin': 'UK',
                'Seller': 'Tesco UK',
                'Type': 'Supermarket',
                'Carbon footprint(tCO2e)': '2',
                'Transport': 'Truck'
            }
        ]

    def serialize(self):
        return {
            'id': self.id,
            'origin': self.origin,
            'trace': self.trace,
        }


@production_trace.route('/api/trace/<id_>', methods=['GET'])
def get_product_trace(id_):
    return jsonify(trace(id_).serialize())
