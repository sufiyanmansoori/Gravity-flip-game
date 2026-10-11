from datetime import date, timedelta

from rest_framework import serializers


class AnalyticsQuerySerializer(serializers.Serializer):
    metric = serializers.CharField(max_length=100, required=False, default='events')
    start = serializers.DateField(required=False)
    end = serializers.DateField(required=False)
    dimension = serializers.CharField(max_length=100, required=False, default='')

    def validate(self, attrs):
        attrs['end'] = attrs.get('end', date.today())
        attrs['start'] = attrs.get('start', attrs['end'] - timedelta(days=30))
        if attrs['start'] > attrs['end']:
            raise serializers.ValidationError('start must be before or equal to end.')
        if (attrs['end'] - attrs['start']).days > 366:
            raise serializers.ValidationError('Analytics windows cannot exceed 366 days.')
        return attrs